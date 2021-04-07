import Projeto from "App/Models/Project"

export default {
    render(projeto: Projeto){
        return {
            id: projeto.id,
            name: projeto.name,
            tag: projeto.tag,
            main_teacher: projeto.main_teacher,
            second_teacher: !projeto.second_teacher ? "Sem coorientador" : projeto.second_teacher,
            institution: projeto.institution,
            start_date: projeto.start_date,
        }
    }
}