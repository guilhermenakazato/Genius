import Projeto from "App/Models/Project"

export default {
    render(project: Project){
        return {
            id: project.id,
            name: project.name,
            tag: project.tag,
            main_teacher: project.main_teacher,
            second_teacher: !project.second_teacher ? "Sem coorientador" : project.second_teacher,
            institution: project.institution,
            start_date: project.start_date,
        }
    }
}