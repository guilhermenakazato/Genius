import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class Achievements extends BaseSchema {
  protected tableName = 'achievements'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id')
      table.integer("user_id").notNullable().references("id").inTable("users")
      table.string("institution", 200).nullable()
      table.string("name", 300).notNullable()
      table.string("position", 300).nullable()
      table.string("type", 300).nullable()
      table.timestamps(true)
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}
