import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Achievement from 'App/Models/Achievement'
import User from 'App/Models/User'
import { DateTime } from 'luxon'

export default class AchievementsController {
  async create({request, params}: HttpContextContract){
    const achievement = request.all()
    const {userId} = params

    const user = await User.findOrFail(userId)
    await user.related("achievements").create(achievement)
    await user.load("achievements")

    return user
  }

  async listAllAchievements(){
    return await Achievement.all()
  }
  
  async getAchievementById({params}: HttpContextContract){
    const {id} = params 
    const achievement = await Achievement.findOrFail(id)

    await achievement.load("user")

    return achievement
  }

  async updateAchievement({params, request}: HttpContextContract) {
    const {id} = params;
    const {institution, name, position, type, customizedType} = request.all()

    const achievement = await Achievement.findOrFail(id);
    achievement.institution = institution;
    achievement.name = name;
    achievement.position = position;
    achievement.type = type;
    achievement.customizedType = customizedType;
    achievement.updatedAt = DateTime.local()

    await achievement.save()

    return achievement
  }

  async deleteAchievement({params}: HttpContextContract) {
    const {id} = params;
    const achievement = await Achievement.findOrFail(id);

    await achievement.delete()
  }
}
