import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class Projects extends BaseSchema {
  protected tableName = 'projects'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.string("name", 300).notNullable().unique()
      table.integer("main_teacher").nullable().references("id").inTable("users")
      table.integer("second_teacher").nullable().references("id").inTable("users")
      table.string("main_teacher_name").nullable()
      table.string("second_teacher_name").nullable()
      table.string("institution", 300).notNullable()
      table.string("start_date", 30).notNullable()
      table.string("abstract_text", 1000).notNullable()

      table.timestamps(true)
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}
