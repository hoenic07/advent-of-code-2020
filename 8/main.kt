import java.io.File

class Command(var name: String, val value: Int, var used: Boolean)

val NOP = "nop";
val JMP = "jmp";
val ACC = "acc";

fun main(args: Array<String>) {
  val commands = parseInput("input.txt");
  findWrongCommand(commands);
}

fun findWrongCommand(commands: Array<Command>){
  commands.forEach {
    val oldName = it.name;

    if(it.name==JMP){
      it.name=NOP;
    }
    else if(it.name == NOP){
      it.name=JMP;
    }

    if(tryRunCommands(commands)){
      return;
    }

    it.name = oldName;
  }
}

fun tryRunCommands(commands: Array<Command>): Boolean{
  var accumulator = 0;
  var currentIndex = 0;
  resetCommands(commands);
  while(true){
    val currentCommand = commands[currentIndex];
    if(currentCommand.used){
      println("Break Accumulator: "+accumulator);
      return false;
    }

    currentCommand.used = true;
    if(currentCommand.name == ACC){
      currentIndex++;
      accumulator += currentCommand.value;
    }
    else if(currentCommand.name ==JMP){
      currentIndex += currentCommand.value;
    }
    else if(currentCommand.name == NOP){
      currentIndex++;
    }

    if(currentIndex >= commands.size){
      break;
    }
  }

  println("Success Accumulator: "+accumulator);

  return true;
}

fun parseInput(fileName: String): Array<Command> {
  return File(fileName).useLines { 
    it.toList().map {
      val res = it.split(" ");
      Command(res[0], res[1].toInt(), false)
    }.toTypedArray();
  }
}

fun resetCommands(commands: Array<Command>){
  commands.forEach { it.used=false }
}