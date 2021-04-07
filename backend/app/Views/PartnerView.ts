import Partner from "App/Models/Partner";

export default {
  render(partner: Partner){
    return {
      id: partner.id,
      follower: partner.follower,
      following: partner.following,
    }
  }
}