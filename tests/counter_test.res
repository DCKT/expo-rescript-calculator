open Test

let assertEqual = (~message, ~a, ~b) => assertion((a, b) => a === b, a, b, ~message)

test("Addition", () => {
  open Key

  assertEqual(
    ~message="Should add 2 numbers",
    ~a=calculate([Number(1.), Operation(Calcul(Add)), Number(1.)]),
    ~b=2.,
  )

  assertEqual(
    ~message="Should add 3 numbers",
    ~a=calculate([
      Number(1.1),
      Operation(Calcul(Add)),
      Number(1.),
      Operation(Calcul(Add)),
      Number(1.),
    ]),
    ~b=3.1,
  )

  assertEqual(
    ~message="Should add 3 numbers",
    ~a=calculate([
      Number(11.),
      Operation(Calcul(Add)),
      Number(1.),
      Operation(Calcul(Add)),
      Number(1.),
    ]),
    ~b=13.,
  )
  assertEqual(
    ~message="Should add 4 numbers",
    ~a=calculate([
      Number(11.),
      Operation(Calcul(Add)),
      Number(1.),
      Operation(Calcul(Add)),
      Number(1.),
      Operation(Calcul(Add)),
      Number(1.),
    ]),
    ~b=14.,
  )
})

test("Substraction", () => {
  open Key

  assertEqual(
    ~message="Should substract 2 numbers",
    ~a=calculate([Number(1.), Operation(Calcul(Substract)), Number(1.)]),
    ~b=0.,
  )

  assertEqual(
    ~message="Should substract 3 numbers",
    ~a=calculate([
      Number(1.),
      Operation(Calcul(Substract)),
      Number(1.),
      Operation(Calcul(Substract)),
      Number(1.),
    ]),
    ~b=-1.,
  )
  assertEqual(
    ~message="Should substract 3 numbers",
    ~a=calculate([
      Number(11.),
      Operation(Calcul(Substract)),
      Number(1.),
      Operation(Calcul(Substract)),
      Number(1.),
    ]),
    ~b=9.,
  )
  assertEqual(
    ~message="Should substract 4 numbers",
    ~a=calculate([
      Number(11.),
      Operation(Calcul(Substract)),
      Number(1.),
      Operation(Calcul(Substract)),
      Number(1.),
      Operation(Calcul(Substract)),
      Number(1.),
    ]),
    ~b=8.,
  )
})

test("Multiply", () => {
  open Key

  assertEqual(
    ~message="Should multiply 2 numbers",
    ~a=calculate([Number(1.), Operation(Calcul(Multiply)), Number(1.)]),
    ~b=1.,
  )

  assertEqual(
    ~message="Should multiply 3 numbers",
    ~a=calculate([
      Number(2.),
      Operation(Calcul(Multiply)),
      Number(1.),
      Operation(Calcul(Multiply)),
      Number(2.),
    ]),
    ~b=4.,
  )
  assertEqual(
    ~message="Should multiply 3 numbers",
    ~a=calculate([
      Number(11.),
      Operation(Calcul(Multiply)),
      Number(1.),
      Operation(Calcul(Multiply)),
      Number(2.),
    ]),
    ~b=22.,
  )
  assertEqual(
    ~message="Should multiply 4 numbers",
    ~a=calculate([
      Number(11.),
      Operation(Calcul(Multiply)),
      Number(2.),
      Operation(Calcul(Multiply)),
      Number(2.),
      Operation(Calcul(Multiply)),
      Number(2.),
    ]),
    ~b=88.,
  )
})

test("Divide", () => {
  open Key

  assertEqual(
    ~message="Should divide 2 numbers",
    ~a=calculate([Number(1.), Operation(Calcul(Divide)), Number(1.)]),
    ~b=1.,
  )

  assertEqual(
    ~message="Should divide 3 numbers",
    ~a=calculate([
      Number(6.),
      Operation(Calcul(Divide)),
      Number(2.),
      Operation(Calcul(Divide)),
      Number(2.),
    ]),
    ~b=1.5,
  )
  assertEqual(
    ~message="Should divide 3 numbers",
    ~a=calculate([
      Number(12.),
      Operation(Calcul(Divide)),
      Number(2.),
      Operation(Calcul(Divide)),
      Number(2.),
    ]),
    ~b=3.,
  )
  assertEqual(
    ~message="Should divide 4 numbers",
    ~a=calculate([
      Number(12.),
      Operation(Calcul(Divide)),
      Number(4.),
      Operation(Calcul(Divide)),
      Number(1.),
      Operation(Calcul(Divide)),
      Number(3.),
    ]),
    ~b=1.,
  )
})

test("Mix", () => {
  open Key

  assertEqual(
    ~message="Should handle every operator",
    ~a=calculate([
      Number(1.),
      Operation(Calcul(Add)),
      Number(2.),
      Operation(Calcul(Multiply)),
      Number(2.),
      Operation(Calcul(Divide)),
      Number(3.),
    ]),
    ~b=2.,
  )
})

test("Modulo", () => {
  open Key

  assertEqual(
    ~message="Should handle modulo",
    ~a=calculate([Number(4.), Operation(Calcul(Modulo)), Number(2.)]),
    ~b=0.,
  )
})
