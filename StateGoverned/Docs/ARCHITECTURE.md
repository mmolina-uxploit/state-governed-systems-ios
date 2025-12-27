# Architecture Decision Record (ADR)
## Sistema iOS Gobernado por Estado

> Este documento es un **ADR simplificado** que describe la decisión arquitectónica central del proyecto y los principios que se derivan de ella.  
> Se presenta como **caso de estudio**, no como artefacto de coordinación de equipo.

---

## Contexto

Este proyecto explora una arquitectura iOS gobernada por estado, diseñada para priorizar:

- claridad semántica  
- testabilidad  
- razonamiento local  
- resistencia al cambio  

Este ADR no describe cómo funciona el código, sino **por qué fue diseñado de esta forma**.  
Modificar esta decisión implica asumir trade-offs explícitos.

---

## Decisión (ADR principal)

**El sistema se modela como una máquina de estados explícita gobernada por tipos.**

Los estados inválidos no deben poder representarse.

Esto implica:
- uso intensivo de `enum` y `struct` inmutables
- eliminación de flags booleanos ambiguos
- modelado explícito de errores y transiciones

**Trade-off asumido:**  
Mayor esfuerzo inicial de modelado a cambio de menor ambigüedad y menos bugs en runtime.

---

## Principios derivados de la decisión

### Tipos como frontera del dominio

El dominio expresa reglas de negocio, no detalles técnicos ni circunstanciales.

- Los errores son parte del dominio (`LoadFailure`, `Recoverability`)
- La UI nunca recibe un `Error` genérico
- El estado de carga no vive dentro del modelo de negocio

**Beneficio:** semántica clara y decisiones de UX conscientes.

---

### Separación Dominio / Sistema

El dominio no conoce:
- SwiftUI
- Networking
- Concurrency
- Frameworks externos

El sistema se adapta al dominio, no al revés.

**Beneficio:** testeo sin mocks y refactors seguros.

---

### Reducer puro como núcleo del sistema

Las transiciones de estado se implementan como funciones puras:

```text
(state, event) -> newState
```

Sin async.
Sin side effects.

### Beneficio: TDD determinístico y razonamiento del sistema sin ejecutar la app.

## UI como proyección pasiva del estado

SwiftUI no decide: reacciona al estado.

Si la UI necesita lógica adicional, el diseño del estado es incorrecto.

### Beneficio: UI predecible y menos bugs de render.

## Alternativas descartadas

- Flags booleanos (isLoading, hasError)

- Lógica de transición en la UI

- Side effects dentro del reducer

- Modelos de dominio contaminados con detalles de API

Estas alternativas reducen el esfuerzo inicial, pero aumentan la ambigüedad y el costo cognitivo a largo plazo.

