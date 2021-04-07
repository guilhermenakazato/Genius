import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import ProjectsParticipant from 'App/Models/ProjectsParticipant';
import ProjectsParticipantView from 'App/Views/ProjectsParticipantView';

export default {
  async create({request}: HttpContextContract) {
    const participantsData = request.all();
    const participants = await ProjectsParticipant.create(participantsData);

    return ProjectsParticipantView.render(participants)
  },
  async listAllParticipants() {
    return await ProjectsParticipant.all()
  }
}
