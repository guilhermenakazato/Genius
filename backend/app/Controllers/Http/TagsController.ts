import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Tag from 'App/Models/Tag'

export default {
  async create({request}: HttpContextContract){

  },
  async getAllTags(){
    return await Tag.all()
  },
  async getTagById({params}: HttpContextContract){

  }
}
