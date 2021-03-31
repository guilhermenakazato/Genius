import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class Projects extends BaseSchema {
  protected tableName = 'projects'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.string("name", 300).notNullable().unique()
      table.string("tag", 100).notNullable()
      table.string("orientador", 200).notNullable()
      table.string("coorientador", 200).nullable()
      table.bigInteger("qtde_orientandos").nullable()
      table.string("instituicao", 300).notNullable()
      table.string("data_inicio", 30).notNullable()
      
      table.timestamps(true)
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}
