import Projeto from "App/Models/Project"

export default {
    render(projeto: Projeto){
        return {
            id: projeto.id,
            name: projeto.name,
            tag: projeto.tag,
            orientador: projeto.orientador,
            coorientador: !projeto.coorientador ? "Sem coorientador" : projeto.coorientador,
            qtde_orientandos: projeto.qtde_orientandos,
            instituicao: projeto.instituicao,
            data_inicio: projeto.data_inicio,
        }
    }
}