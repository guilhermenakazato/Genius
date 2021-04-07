import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Achievement from 'App/Models/Achievement'
import AchievementView from 'App/Views/AchievementView'

export default {
  async create({request}: HttpContextContract){
    const achievementData = request.all()
    const achievement = await Achievement.create(achievementData)

    return AchievementView.render(achievement);
  },
  async listAllAchievements(){
    return await Achievement.all()
  }
}
