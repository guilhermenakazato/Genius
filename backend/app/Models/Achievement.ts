import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import User from './User'

export default class Achievement extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column()
  public user_id: number

  @column()
  public institution: string

  @column()
  public name: string

  @column()
  public position: string

  @column()
  public type: string

  @column({
    columnName: 'customized_type'
  })
  public customizedType: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
  
  @belongsTo(() => User, {
    localKey: "user_id"
  })
  public user: BelongsTo<typeof User>
}
