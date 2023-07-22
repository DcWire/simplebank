createdb:
	docker exec -it my-postgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it my-postgres dropdb simple_bank

postgres:
	docker run --name my-postgres -e POSTGRES_USER=root -e POSTGRES_PASSWORD=anas -p 5432:5432 -d postgres:12-alpine
	
migrateup: 
	migrate -path db/migration -database "postgresql://root:anas@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown: 
	migrate -path db/migration -database "postgresql://root:anas@localhost:5432/simple_bank?sslmode=disable" -verbose down 

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server: 
	go run main.go

mock: 
	mockgen -package mock_db -destination db/mock/store.go github.com/DcWire/simplebank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migratedown test sqlc server mock
