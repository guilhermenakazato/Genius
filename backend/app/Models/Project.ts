import { DateTime } from 'luxon'
import { BaseModel, column } from '@ioc:Adonis/Lucid/Orm'

export default class Projeto extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column()
  public name: string

  @column()
  public tag: string
  
  @column()
  public orientador: string

  @column()
  public coorientador: string

  @column()
  public qtde_orientandos: number

  @column()
  public instituicao: string

  @column()
  public data_inicio: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
}
