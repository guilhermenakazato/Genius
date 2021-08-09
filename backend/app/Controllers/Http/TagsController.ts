import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Tag from 'App/Models/Tag'

export default class TagsController {
  async createTag({request}: HttpContextContract){
    const tagData = request.all()
    const tag = await Tag.create(tagData)
    
    return tag
  }

  async getAllTags(){
    const tags = await Tag.all()

    for(let i = 0; i < tags.length; i++) {
      await tags[i].load("projects")
    }

    return tags
  }
  
  async getTagById({params}: HttpContextContract){
    const {id} = params
    const tag = await Tag.findOrFail(id)

    return tag
  }
}
