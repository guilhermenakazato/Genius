import { DateTime } from 'luxon'
import { BaseModel, column } from '@ioc:Adonis/Lucid/Orm'

export default class ProjectsParticipant extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column()
  public participant_id: number
  
  @column()
  public project_id: number

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
}
