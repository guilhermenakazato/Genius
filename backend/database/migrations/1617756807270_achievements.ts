import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class Achievements extends BaseSchema {
  protected tableName = 'achievements'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.integer("user_id").notNullable().references("id").inTable("users").onDelete("CASCADE")
      table.string("institution", 200).notNullable()
      table.string("name", 300).notNullable()
      table.string("position", 300).nullable()
      table.string("type", 300).nullable()
      table.string("customized_type").nullable()
      table.timestamps(true)
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}
