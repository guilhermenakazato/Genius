import { DateTime } from 'luxon'
import Hash from '@ioc:Adonis/Core/Hash'
import {
  column,
  beforeSave,
  BaseModel,
  manyToMany,
  ManyToMany,
  hasMany,
  HasMany,
} from '@ioc:Adonis/Lucid/Orm'
import Project from './Project'
import Achievement from './Achievement'
import Survey from './Survey'
import Tag from './Tag'

export default class User extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column()
  public name: string

  @column()
  public username: string

  @column()
  public email: string

  @column()
  public password: string

  @column()
  public type: string

  @column()
  public age: string

  @column()
  public local: string

  @column()
  public institution: string

  @column()
  public formation: string

  @column()
  public bio: string

  @column()
  public verified: string

  @column()
  public rememberMeToken?: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @beforeSave()
  public static async hashPassword (user: User) {
    if (user.$dirty.password) {
      user.password = await Hash.make(user.password)
    }
  }

  @manyToMany(() => Project, {
    pivotTable: "user_projects"
  })
  public projects: ManyToMany<typeof Project>

  @hasMany(() => Achievement, {
    foreignKey: "user_id"
  })
  public achievements: HasMany<typeof Achievement>

  @hasMany(() => Survey, {
    foreignKey: "user_id"
  })
  public surveys: HasMany<typeof Survey>

  @manyToMany(() => Project, {
    pivotTable: "saved_projects"
  })
  public saved: ManyToMany<typeof Project>

  @manyToMany(() => Tag, {
    pivotTable: "users_tags"
  })
  public tags: ManyToMany<typeof Tag>
}
