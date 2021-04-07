import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class Projects extends BaseSchema {
  protected tableName = 'projects'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.string("name", 300).notNullable().unique()
      table.string("tag", 100).notNullable()
      table.integer("main_teacher").notNullable().references("id").inTable("users")
      table.string("second_teacher", 200).nullable().references("id").inTable("users")
      table.string("institution", 300).notNullable()
      table.string("start_date", 30).notNullable()
      
      table.timestamps(true)
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}
