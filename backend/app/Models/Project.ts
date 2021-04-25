import { DateTime } from 'luxon'
import { BaseModel, column, ManyToMany, manyToMany } from '@ioc:Adonis/Lucid/Orm'
import User from './User'
import Tag from './Tag'

export default class Project extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column()
  public name: string

  @column()
  public tag: string
  
  @column()
  public main_teacher: number

  @column()
  public second_teacher: number

  @column()
  public institution: string

  @column()
  public start_date: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @manyToMany(() => User)
  public participants: ManyToMany<typeof User>

  @manyToMany(() => User)
  public savedBy: ManyToMany<typeof User>

  @manyToMany(() => Tag)
  public tags: ManyToMany<typeof Tag>
}
