import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class ProjectsUseurs extends BaseSchema {
  protected tableName = 'user_projects'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id')
      table.integer("user_id").unsigned().notNullable().references("id").inTable("users")
      table.integer("project_id").unsigned().notNullable().references("id").inTable("projects")
      table.timestamps(true)
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}
