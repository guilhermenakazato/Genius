import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Project from 'App/Models/Project'
import Tag from 'App/Models/Tag'
import { DateTime } from 'luxon'
import User from '../../Models/User'

export default class UsersController {
  async listAllUsers() {
    const user = await User.all()
    return user
  }

  async createUser({ request }: HttpContextContract) {
    const data = request.all()
    const user = await User.create(data)

    return user
  }

  async getUserById({ params }: HttpContextContract) {
    const { id } = params
    const user = await User.findOrFail(id)

    await user.load('achievements')
    await user.load('projects', project => {
      project.preload("participants")
      project.preload('tags')
      project.preload("savedBy")
      project.preload("likedBy")
    })
    await user.load('surveys')
    await user.load("tags")
    await user.load("followers")
    await user.load("following")
    await user.load("liked")

    return user
  }

  async deleteUser({ params }: HttpContextContract) {
    const { id } = params
    const user = await User.findOrFail(id)

    await user.load("projects")
    
    if(user.projects.length >= 1) {
      for(let i = 0; i < user.projects.length; i++) {
        const project = await Project.find(user.projects[i].id);
        await project?.load("participants")
        
        await project?.related("participants").detach([id]);
      
        if(user.username == project?.main_teacher) {
          project.main_teacher = null
          await project.save()
        } else if(user.username == project?.second_teacher) {
          project.second_teacher = null
          await project.save()
        }

        if(project?.participants.length == 1) {
          await this.deleteProjectSinceThereAreNoParticipantsInIt(project);
        }
      }
    }

    await user.related("tags").sync([])
    await user.related("liked").sync([])
    await user.related("saved").sync([])
    await user.related("followers").sync([])
    await user.related("following").sync([])
    
    await user.load("tags") 
    await user.load("achievements") 
    await user.load("followers")
    await user.load("following")
    await user.load("liked") 
    await user.load("saved") 
    await user.load("surveys")

    await user.delete()
  }

  async deleteProjectSinceThereAreNoParticipantsInIt(project: Project) {
    await project.related("deleteRequests").sync([])
    await project.related("savedBy").sync([])
    await project.related("tags").sync([])
    await project.related("likedBy").sync([])

    await project.delete()
  }

  async updateUser({ params, request }: HttpContextContract) {
    const { id } = params
    const { name, username, email, password, type, age, local, formation, institution, bio, tags, verified } =
      request.all()
    const user = await User.findOrFail(id)

    user.name = name
    user.username = username
    user.email = email
    user.password = password
    user.type = type
    user.age = age
    user.local = local
    user.formation = formation
    user.institution = institution
    user.bio = bio
    user.verified = verified
    user.updatedAt = DateTime.local()

    await user.save()

    if(tags != null && tags != undefined) {
      await this.updateUserTagRelationship(tags, user);
    }
    
    await user.load("tags")

    return user
  }

  async saveProject({ request }: HttpContextContract) {
    const { projectId, userId } = request.all()

    const user = await User.findOrFail(userId)
    await user.related('saved').attach([projectId])

    await user.load('saved')

    return user
  }

  async removeSavedProject({request}: HttpContextContract) {
    const {projectId, userId} = request.all()
    
    const user = await User.findOrFail(userId)
    await user.related('saved').detach([projectId])

    await user.load('saved')

    return user
  }

  async likeProject({request}: HttpContextContract) {
    const {projectId, userId} = request.all()
    
    const user = await User.findOrFail(userId)
    await user.related("liked").attach([projectId]);

    await user.load('liked')

    return user
  }

  async dislikeProject({request}: HttpContextContract) {
    const {projectId, userId} = request.all()
    
    const user = await User.findOrFail(userId)
    await user.related("liked").detach([projectId]);

    await user.load('liked')

    return user
  }

  async verifyIfUsernameAlreadyExists({ params }: HttpContextContract) {
    const { username } = params
    const user = await User.findByOrFail('username', username)

    return user
  }

  async verifyIfEmailAlreadyExists({ params }: HttpContextContract) {
    const { email } = params
    const user = await User.findByOrFail('email', email)

    return user
  }

  async updateUserTagRelationship(tags: string[], user: User) {
    let arrayOfTagIds: number[] = []

    for (let i = 0; i < tags.length; i++) {
      const tag = await Tag.findBy('name', tags[i])

      if (tag == null) {
        const newTag = new Tag()

        newTag.name = tags[i]

        await newTag.save()
        arrayOfTagIds.push(newTag.id)
      } else if (tag instanceof Tag) {
        arrayOfTagIds.push(tag.id)
      }
    }

    await user.related('tags').sync(arrayOfTagIds)
  }

  async follow({request}: HttpContextContract) {
    const {user_id, follower_id} = request.all();

    const followedUser = await User.findOrFail(user_id)
    await followedUser.related("followers").attach([follower_id])
    
    const userFollowing = await User.findOrFail(follower_id)

    await followedUser.load("following")
    await followedUser.load("followers")

    await userFollowing.load("following")
    await userFollowing.load("followers")

    return [
      followedUser,
      userFollowing
    ]
  }

  async unfollow({request}: HttpContextContract) {
    const {user_id, follower_id, removing_follower} = request.all();
    const followedUser: User = await User.findOrFail(user_id)
    const follower: User = await User.findOrFail(follower_id)

    if(removing_follower) {
      await followedUser.related("followers").detach([follower_id])
    } else {
      await follower.related("following").detach([user_id])
    }

    await followedUser.load("following")
    await followedUser.load("followers")

    await follower.load("following")
    await follower.load("followers")

    return [
      followedUser,
      follower
    ]
  }

  async changePassword({request, params}: HttpContextContract) {
    const {userId} = params;
    const {password} = request.all()

    const user = await User.findOrFail(userId);
    user.password = password

    await user.save()

    return user
  }

  async setDeviceToken({request, params}: HttpContextContract) {
    const {userId} = params;
    const {device_token} = request.all()

    const user = await User.findOrFail(userId)
    user.deviceToken = device_token

    await user.save()

    return user
  }
}
