# Desarrollo Guiado por Tests (TDD) en StateGoverned

En `StateGoverned`, TDD se usa como **herramienta de diseño**, no solo como técnica de testing.  
Se integra con una arquitectura guiada por tipos (`Type-Driven`) y por estado (`State-Driven`) para construir un sistema predecible y fácil de razonar.

---

## TDD como diseño

Escribir el test primero obliga a definir:
- qué hace el código
- qué entradas acepta
- qué salidas produce
- qué estados son válidos

El test actúa como el primer consumidor de la API.

Esto produce código:
- naturalmente testeable
- con bajo acoplamiento
- fácil de entender

---

## Ciclo Red – Green – Refactor

En la capa de dominio se aplica TDD de forma estricta:

1. **Red:** se escribe un test que falla y expresa una nueva regla.
2. **Green:** se implementa el mínimo código para que pase.
3. **Refactor:** se mejora el diseño con los tests como red de seguridad.

---

## TDD y arquitectura guiada por estado

La arquitectura `State-Driven` potencia TDD:

- Los reducers son funciones puras `(State, Event) -> State`, fáciles de testear.
- Los estados son inmutables, lo que hace los tests determinísticos.
- El dominio se modela de forma explícita, sin mezclar UI ni red.

---

## En síntesis

En `StateGoverned`, TDD no valida el diseño:  
**lo fuerza a existir con claridad desde el inicio**.
