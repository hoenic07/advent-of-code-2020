package main

import (
    "fmt"
    "io/ioutil"
    s "strings"
    "regexp"
)

import "strconv"

func main() {
    two()
}

func one(){
  dat, _ := ioutil.ReadFile("input.txt")

  input := string(dat)
  lines := s.Split(input,"\n")
  pattern := "(?P<Lower>[0-9]*)-(?P<Upper>[0-9]*) (?P<Character>[a-z]{1}): (?P<Password>[a-z]*)"

  overallCount := 0

  for _,line := range lines {
    params := getParams(pattern, line)
    lower, _ := strconv.Atoi(params["Lower"])
    upper, _ := strconv.Atoi(params["Upper"])
    char := params["Character"]
    pw := params["Password"]
    countInPw := len(regexp.MustCompile(char).FindAllStringIndex(pw, -1))
    isMatch := countInPw >= lower && countInPw <= upper
    fmt.Println(line)
    fmt.Printf("%d %d %d %s %s %s\n", lower, upper, countInPw, char, pw, isMatch)
    if(isMatch){
      overallCount+=1
    }
  }

  fmt.Print(overallCount)
}

func two(){
  dat, _ := ioutil.ReadFile("input.txt")

  input := string(dat)
  lines := s.Split(input,"\n")
  pattern := "(?P<Lower>[0-9]*)-(?P<Upper>[0-9]*) (?P<Character>[a-z]{1}): (?P<Password>[a-z]*)"

  overallCount := 0

  for _,line := range lines {
    if(len(line)==0) {
      continue; 
    }
    params := getParams(pattern, line)
    lower, _ := strconv.Atoi(params["Lower"])
    upper, _ := strconv.Atoi(params["Upper"])
    char := params["Character"][0]
    pw := params["Password"]
    
    isMatch := (pw[lower-1] == char && pw[upper-1] != char) || (pw[lower-1] != char && pw[upper-1] == char)

    if(isMatch){
      overallCount+=1
    }
  }

  fmt.Print(overallCount)
}

func getParams(regEx, url string) (paramsMap map[string]string) {

    var compRegEx = regexp.MustCompile(regEx)
    match := compRegEx.FindStringSubmatch(url)

    paramsMap = make(map[string]string)
    for i, name := range compRegEx.SubexpNames() {
        if i > 0 && i <= len(match) {
            paramsMap[name] = match[i]
        }
    }
    return
}