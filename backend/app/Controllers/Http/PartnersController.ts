import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Partner from 'App/Models/Partner'
import PartnerView from 'App/Views/PartnerView'

export default {
  async create({request}: HttpContextContract){
    const partnerData = request.all()
    const partner = await Partner.create(partnerData)

    return PartnerView.render(partner)
  },
  async listAllPartners(){
    return await Partner.all();
  }
}
