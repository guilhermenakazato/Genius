import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class Surveys extends BaseSchema {
  protected tableName = 'surveys'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.integer("user_id").notNullable().references("id").inTable("users").onDelete("CASCADE")
      table.string("name", 500).notNullable()
      table.string("link", 500).notNullable()
      table.timestamps(true)
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}
