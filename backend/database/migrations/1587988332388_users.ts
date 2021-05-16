import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class UsersSchema extends BaseSchema {
  protected tableName = 'users'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.string("name").notNullable()
      table.string("username", 80).notNullable().unique()
      table.string('email', 255).notNullable().unique()
      table.string('password', 180).notNullable()
      table.string("type", 30).notNullable()
      table.string("age", 60).notNullable()
      table.string("local", 200).notNullable()      
      table.string("formation", 200).notNullable()
      table.string("institution", 200).notNullable()
      table.string("bio", 180).nullable()
      table.timestamps(true)
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}
