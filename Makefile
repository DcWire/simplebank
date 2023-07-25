createdb:
	docker exec -it my-postgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it my-postgres dropdb simple_bank

postgres:
	docker run --name my-postgres -e POSTGRES_USER=root -e POSTGRES_PASSWORD=anas -p 5432:5432 -d postgres:12-alpine
	
migrateup: 
	migrate -path db/migration -database "postgresql://root:anas@localhost:5432/simple_bank?sslmode=disable" -verbose up

migrateup1: 
	migrate -path db/migration -database "postgresql://root:anas@localhost:5432/simple_bank?sslmode=disable" -verbose up 1 

migratedown: 
	migrate -path db/migration -database "postgresql://root:anas@localhost:5432/simple_bank?sslmode=disable" -verbose down 

migratedown1 : 
	migrate -path db/migration -database "postgresql://root:anas@localhost:5432/simple_bank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server: 
	go run main.go

mock: 
	mockgen -package mock_db -destination db/mock/store.go github.com/DcWire/simplebank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migratedown migrateup1 migratedown1 test sqlc server mock 
