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
  public abstractText: string
  
  @column()
  public main_teacher: string | null

  @column()
  public second_teacher: string | null

  @column()
  public main_teacher_name: string

  @column()
  public second_teacher_name: string

  @column()
  public institution: string

  @column()
  public start_date: string

  @column()
  public email: string
  
  @column()
  public participants_full_name: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @manyToMany(() => User, {
    pivotTable: "user_projects"
  })
  public participants: ManyToMany<typeof User>

  @manyToMany(() => User, {
    pivotTable: "saved_projects"
  })
  public savedBy: ManyToMany<typeof User>

  @manyToMany(() => User, {
    pivotTable: "likes"
  })
  public likedBy: ManyToMany<typeof User>

  @manyToMany(() => Tag)
  public tags: ManyToMany<typeof Tag>

  @manyToMany(() => User, {
    pivotTable: 'delete_requests'
  })
  public deleteRequests: ManyToMany<typeof User>
}
