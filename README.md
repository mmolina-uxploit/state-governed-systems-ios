# iOS · Swift · App Systems

## Modelado de Decisiones y Estados

Este repositorio no es una demo de UI ni un catálogo de features.

Es un **argumento técnico ejecutable**: una exploración de cómo el diseño de tipos y estados puede gobernar un sistema completo —desde el dominio hasta la interfaz— eliminando errores antes de que existan.

La app resultante es mínima por diseño. El valor del proyecto no está en lo que hace, sino en **cómo decide existir**.

---

## 🎯 Objetivo del Proyecto

Construir una app iOS que demuestre cómo:

* El sistema de tipos de Swift puede actuar como **contrato del dominio**
* Los estados inválidos pueden ser **imposibles de representar**
* La UI puede convertirse en una **proyección pasiva del estado**, no en un lugar de decisiones
* La documentación puede ser parte activa del sistema, no un artefacto posterior

El foco no es SpaceX, ni networking, ni SwiftUI.

El foco es **pensar sistemas**.

---

## 🧠 Principio Rector

> Las decisiones de dominio deben ser verificables por el compilador.

Este proyecto parte de una premisa práctica:

* Las decisiones críticas no deben depender de convenciones de equipo
* No deben vivir en la UI
* No deben requerir tests defensivos para descubrir inconsistencias

Las decisiones deben residir en el dominio, expresadas mediante tipos y transiciones explícitas, donde el compilador pueda validarlas de forma determinística.

La UI se limita a renderizar el estado actual del sistema.

---

## 🛰️ Dominio Elegido

Se utiliza la **API pública de SpaceX** como fuente de datos real.

Motivo de la elección:

* Datos incompletos y opcionales
* Estados temporales (pasado / futuro)
* Fallos reales de red y parseo
* Necesidad de distinguir datos completos vs parciales

Esto fuerza decisiones de diseño reales sin necesidad de backend propio.

La API es solo un insumo. El dominio modelado es:

> “Un sistema que intenta obtener y representar información de lanzamientos, sabiendo que puede fallar o recibir datos imperfectos.”

---

## 🧩 Estados del Sistema (Verdad de Producto)

El sistema puede encontrarse en uno —y solo uno— de los siguientes estados reales:

* Estado inicial (nada ocurrió aún)
* Carga en progreso (con o sin datos previos)
* Datos cargados correctamente
* Datos cargados de forma parcial
* Error recuperable
* Error no recuperable

Estos estados son **mutuamente excluyentes**.

Cualquier combinación fuera de esta lista es considerada **ilegal** y no debe poder representarse en el código.

---

## 🚫 Estados Prohibidos por Diseño

El sistema **no permite** representar situaciones como:

* Cargando y en error al mismo tiempo
* Error sin saber si es recuperable
* Datos parciales tratados como completos
* Retry disponible en errores fatales
* Estados ambiguos que requieran lógica defensiva

Si algo de esto es posible, el diseño se considera incorrecto.

---

## 🧱 Enfoque de Diseño

El proyecto sigue estos principios:

* **Type-driven design**: los tipos expresan reglas del dominio
* **State-driven architecture**: el estado gobierna el flujo
* **Inmutabilidad por defecto**: la mutación es una decisión explícita
* **Fail fast en compile time**: los errores estructurales no llegan a runtime
* **Funciones puras para transiciones**: el sistema puede razonarse sin ejecutarse

---

## 🔁 Arquitectura Conceptual

El sistema se organiza alrededor de cuatro conceptos:

1. **Estado** — Qué puede existir
2. **Eventos** — Qué puede pasar
3. **Transiciones** — Cómo cambia el mundo
4. **Proyección UI** — Cómo se ve ese estado

La red, la concurrencia y SwiftUI se introducen **después** de que estos conceptos están claros.

---

## 📂 Estructura del Repositorio (Conceptual)

* `/Domain`

  * Estados
  * Eventos
  * Reducer (función pura de transición)

* `/System`

  * Concurrencia
  * Networking
  * Cancelación

* `/UI`

  * Vistas SwiftUI
  * Renderizado basado en estado

* `/Docs`

  * Decisiones arquitectónicas
  * Trade-offs explícitos

Cada archivo debe poder responder:

> ¿Qué decisión vive acá?

Si no puede responderla, no debería existir.

---

## 🧪 Criterios de Validación

El proyecto se considera exitoso si:

* La UI no contiene lógica de negocio
* Los estados inválidos no compilan
* El sistema puede explicarse sin mostrar pantallas
* Cada transición es explícita y testeable
* El README se puede leer como un argumento técnico coherente

---

## 🧠 Cierre Técnico

Este repositorio no busca demostrar conocimiento de frameworks ni patrones de moda.

Busca demostrar una forma de ingeniería orientada a:

* Reducción de riesgo sistémico
* Eliminación de clases completas de bugs
* Escalabilidad cognitiva en equipos
* Refactors seguros a largo plazo

El diseño explícito de estados y transiciones no es un lujo académico: es una estrategia para reducir costos de mantenimiento y dependencia de conocimiento tácito.

Cuando el dominio está correctamente modelado:

* El compilador detecta inconsistencias temprano
* Los tests validan comportamiento, no corrigen diseño
* La UI permanece estable ante cambios internos

Este enfoque es especialmente valioso en contextos donde:

* El producto evoluciona rápidamente
* Los equipos crecen o rotan
* El costo de un bug en producción es alto

Ese es el público de este proyecto.

---

## 📌 Orden de Desarrollo

A partir de este README, el proyecto se desarrolla estrictamente en este orden:

1. Modelado de estados como tipos (contrato del dominio)
2. Definición de eventos explícitos
3. Función pura de transición (reducer)
4. Introducción controlada de concurrencia
5. Proyección del estado en SwiftUI

El código es la consecuencia.

Las decisiones vienen primero.
