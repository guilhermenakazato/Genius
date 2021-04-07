import Achievement from 'App/Models/Achievement'

export default {
  render(achievement: Achievement) {
    return {
      id: achievement.id,
      user_id: achievement.user_id,
      institution: achievement.institution,
      name: achievement.name,
      position: achievement.position,
      type: achievement.type
    }
  },
}
