import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Achievement from 'App/Models/Achievement'

export default class AchievementsController {
  async create({request}: HttpContextContract){
    const achievementData = request.all()
    const achievement = await Achievement.create(achievementData)

    return achievement
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
}
