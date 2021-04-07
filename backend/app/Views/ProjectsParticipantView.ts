import ProjectsParticipant from "App/Models/ProjectsParticipant";

export default {
  render(participants: ProjectsParticipant){
    return {
      id: participants.id,
      participant_id: participants.participant_id,
      project_id: participants.project_id,
    }
  }
}