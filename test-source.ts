// Simple test function
function greet(name: string): void {
    console.log(`Hello, ${name}!`);
}

class Calculator {
    add(a: number, b: number): number {
        return a + b;
    }
}

const calc = new Calculator();
const result = calc.add(5, 10);
console.log(result);
