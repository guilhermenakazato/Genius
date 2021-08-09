import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class Projects extends BaseSchema {
  protected tableName = 'projects'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.string("name", 300).notNullable().unique()
      table.string("main_teacher").nullable().references("username").inTable("users")
      table.string("second_teacher").nullable().references("username").inTable("users")
      table.string("main_teacher_name").nullable()
      table.string("second_teacher_name").nullable()
      table.string("institution", 300).notNullable()
      table.string("start_date", 30).notNullable()
      table.string("abstract_text", 20000).notNullable()
      table.string("email").notNullable().unique()
      table.string("participants_full_name").notNullable()

      table.timestamps(true)
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}
