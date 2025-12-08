package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"slices"
	"sort"
	"strconv"
	"strings"
)

type Vec3 struct {
	x, y, z int
}

type Pair struct {
	a, b Vec3
}

func (v1 Vec3) distance(v2 Vec3) int {
	sum := (v1.x-v2.x)*(v1.x-v2.x) + (v1.y-v2.y)*(v1.y-v2.y) + (v1.z-v2.z)*(v1.z-v2.z)
	return int(math.Abs(math.Sqrt(float64(sum))))
}

func pairs(fileName string) ([]Pair, int) {
	var vecs []Vec3
	var pairs []Pair

	file, _ := os.Open(fileName)
	defer file.Close()

	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		xyz := strings.Split(scanner.Text(), ",")
		x, _ := strconv.Atoi(xyz[0])
		y, _ := strconv.Atoi(xyz[1])
		z, _ := strconv.Atoi(xyz[2])

		vecs = append(vecs, Vec3{x, y, z})
	}

	for index, vec := range vecs {
		for j := index + 1; j < len(vecs); j++ {
			pairs = append(pairs, Pair{vec, vecs[j]})
		}
	}

	sort.Slice(pairs, func(i, j int) bool {
		return pairs[i].a.distance(pairs[i].b) < pairs[j].a.distance(pairs[j].b)
	})

	return pairs, len(vecs)
}

func find(circuits *[][]Vec3, vec Vec3) int {
	for i, circuit := range *circuits {
		if slices.Contains(circuit, vec) {
			return i
		}
	}
	return -1
}

func puzzle(pairs *[]Pair, p1_len, p2_len int) (int, int) {
	var circuits [][]Vec3
	var p1, p2, counter int

	for i, pair := range *pairs {
		if i > p1_len-1 && p1 == 0 {
			sort.Slice(circuits, func(i, j int) bool {
				return len(circuits[i]) > len(circuits[j])
			})

			p1 = len(circuits[0]) * len(circuits[1]) * len(circuits[2])
		}

		if len(circuits) == 0 {
			circuits = append(circuits, make([]Vec3, 2))
			circuits[0][0] = pair.a
			circuits[0][1] = pair.b
			counter += 2

			if counter == p2_len {
				p2 = pair.a.x * pair.b.x
				break
			}

			continue
		}

		index1 := find(&circuits, pair.a)
		index2 := find(&circuits, pair.b)

		if index1 == -1 && index2 == -1 {
			circuits = append(circuits, make([]Vec3, 2))
			circuits[len(circuits)-1][0] = pair.a
			circuits[len(circuits)-1][1] = pair.b
			counter += 2

			if counter == p2_len {
				p2 = pair.a.x * pair.b.x
				break
			}

			continue
		}

		if index1 == index2 {
			continue
		}

		if index1 != -1 && index2 != -1 {
			circuits[index1] = append(circuits[index1], circuits[index2]...)
			circuits[index2] = make([]Vec3, 0)

			continue
		}

		if index1 != -1 {
			circuits[index1] = append(circuits[index1], pair.b)
		} else if index2 != -1 {
			circuits[index2] = append(circuits[index2], pair.a)
		}

		counter += 1

		if counter == p2_len {
			p2 = pair.a.x * pair.b.x
			break
		}
	}

	return p1, p2
}

func main() {
	pairs, len := pairs("input")
	arg, _ := strconv.Atoi(os.Args[1])
	p1, p2 := puzzle(&pairs, arg, len)

	fmt.Println(p1)
	fmt.Println(p2)
}
