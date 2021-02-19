import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class UsuariosSchema extends BaseSchema {
  protected tableName = 'usuarios'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.string("username", 80).notNullable()
      table.string('email', 255).notNullable().unique()
      table.string('password', 180).notNullable()
      table.string("type", 30).notNullable()
      table.string("age", 60).notNullable()
      table.string("local", 200).notNullable()
      table.string('remember_me_token').nullable().defaultTo("true")
      table.timestamps(true)
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}
