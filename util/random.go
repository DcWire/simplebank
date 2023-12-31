package util

import (
	"fmt"
	"math/rand"
	"strings"
)

const alphabet = "abcdefghijklmnopqrstuvwxyz"

// Generates a random number between max and min
func RandomInt(min int64, max int64) int64 {
	return min + rand.Int63n(max-min+1)
}

// Generates a random string of length n
func RandomString(n int) string {
	var sb strings.Builder

	k := len(alphabet)
	for i := 0; i < n; i++ {
		c := alphabet[rand.Intn(k)]
		sb.WriteByte(c)
	}

	return sb.String()
}

// Generates a random owner name
func RandomOwner() string {
	return RandomString(6)
}

// Generate random money
func RandomMoney() int64 {
	return RandomInt(0, 1000)
}

// Generate random currency
func RandomCurrency() string {
	currencies := []string{USD, EUR, CAD}
	n := len(currencies)
	return currencies[rand.Intn(n)]
}

func RandomEmail() string {
	return fmt.Sprintf("%s@email.com", RandomString(6))
}
