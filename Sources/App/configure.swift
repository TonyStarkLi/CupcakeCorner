import Vapor
import Leaf
import Fluent
import FluentSQLite

/// Called before your application initializes.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#configureswift)
public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
) throws {
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Configure the rest of your application here
	
	// For rendering HTML cross all files
	try services.register(LeafProvider())
	config.prefer(LeafRenderer.self, for: ViewRenderer.self)
	
	// Database set up
	let directoryConfig = DirectoryConfig.detect()
	services.register(directoryConfig)
	
	try services.register(FluentSQLiteProvider())
	
	// generic databse place
	var databaseConfig = DatabasesConfig()
	let db = try SQLiteDatabase(storage: .file(path: "\(directoryConfig.workDir)cupcakes.db"))
	databaseConfig.add(database: db, as: .sqlite)
	services.register(databaseConfig)
	
	// tell to create database of cupcake
	var migrationConfig = MigrationConfig()
	migrationConfig.add(model: Cupcake.self, database: .sqlite)
	services.register(migrationConfig)
}
