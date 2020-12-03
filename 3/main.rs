use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;

fn main() {
  let tree_count1 = calc_trees(1,1);
  let tree_count2 = calc_trees(3,1);
  let tree_count3 = calc_trees(5,1);
  let tree_count4 = calc_trees(7,1);
  let tree_count5 = calc_trees(1,2);
  println!("Tree Count: {}", tree_count1);
  println!("Tree Count: {}", tree_count2);
  println!("Tree Count: {}", tree_count3);
  println!("Tree Count: {}", tree_count4);
  println!("Tree Count: {}", tree_count5);
  println!("Final Count: {}", tree_count1*tree_count2*tree_count3*tree_count4*tree_count5);
}

fn calc_trees(right: usize, down: usize) -> usize{
  let mut tree_count = 0;
  let mut i = 0;
  let mut j = 0;
  if let Ok(lines) = read_lines("input.txt") {
    for line in lines {
        if let Ok(l) = line {
          if i % down == 0 {
            let pos_right = (right*j)%l.chars().count();
            if l.as_bytes()[pos_right] == "#".as_bytes()[0] {
              tree_count = tree_count+1;
            }
            j = j+1;
          }
        }
        i = i+1;
    }
  }
  tree_count
}

fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where P: AsRef<Path>, {
    let file = File::open(filename)?;
    Ok(io::BufReader::new(file).lines())
}