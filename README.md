# StateGoverned

`StateGoverned` es una aplicación iOS escrita en SwiftUI que funciona como **caso de estudio** de una arquitectura guiada por estado, tipos y decisiones explícitas.

La app consume datos públicos de SpaceX, pero el objetivo principal no es el dominio espacial, sino **explorar cómo diseñar sistemas predecibles, testeables y razonables desde su núcleo**.

---

## Qué demuestra este proyecto

Este repositorio no es un tutorial paso a paso ni una plantilla de producción.  
Es un ejemplo concreto de cómo:

- modelar el dominio usando el sistema de tipos
- gobernar la aplicación desde estados explícitos
- separar lógica pura de infraestructura
- usar TDD como herramienta de diseño
- documentar decisiones arquitectónicas como parte del sistema

---

## Arquitectura guiada por estado

El sistema sigue un flujo unidireccional:

- **State**  
  Representa el estado completo y válido de la aplicación.

- **Event**  
  Describe hechos que pueden ocurrir (acciones del usuario o del sistema).

- **Reducer**  
  Función pura `(State, Event) -> State` que define todas las transiciones posibles.

- **View (SwiftUI)**  
  Proyección pasiva del estado. La UI no decide, reacciona.

Este enfoque permite razonar sobre el sistema sin ejecutar la app y trasladar errores del runtime al compile time.

---

## Documentación

Todo el material conceptual vive en [`Docs/`](Docs/README.md), incluyendo:

- **ARCHITECTURE.md**  
  Decisiones arquitectónicas fundamentales y trade-offs asumidos.

- **TDD-AND-STATE-DRIVEN-DESIGN.md**  
  Uso de TDD como herramienta de diseño en una arquitectura guiada por estado.

Estos documentos explican **por qué el código existe en esta forma**, no cómo escribirlo.

---

## Cómo ejecutar el proyecto

1. Clonar el repositorio.
2. Abrir `StateGoverned.xcodeproj` en Xcode.
3. Ejecutar en simulador o dispositivo físico.

---

## Nota final

Este proyecto prioriza **claridad conceptual sobre conveniencia inmediata**.  
Algunas decisiones implican más trabajo inicial, pero permiten un sistema más fácil de entender, modificar y discutir.

Ese trade-off es intencional.
