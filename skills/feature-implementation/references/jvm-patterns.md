# Java/Kotlin Implementation Patterns

## Project Structure
- Maven: `src/main/java/`, `src/test/java/`, `pom.xml`
- Gradle: same layout, `build.gradle` or `build.gradle.kts`
- Package names match directory structure

## Java
- Records for DTOs (Java 16+): `public record UserDTO(String name, String email) {}`
- Sealed interfaces for type hierarchies (Java 17+)
- `var` for local variables when type is obvious
- Avoid checked exceptions in new code — prefer unchecked + proper handling

## Kotlin
- Data classes for DTOs: `data class User(val name: String, val email: String)`
- Null safety: use `?` types, avoid `!!`
- Extension functions for utility methods
- Coroutines for async (`suspend fun`, `launch`, `async`)

## Spring Boot
- `@RestController` + `@RequestMapping` for endpoints
- Constructor injection (no field injection)
- `@Service`, `@Repository`, `@Component` for DI
- `application.yml` for configuration

## Database
- JPA/Hibernate: entity classes with `@Entity`, `@Table`
- JDBC Template for simple queries
- Flyway or Liquibase for migrations
- Always use parameterized queries

## Testing
- JUnit 5 + Mockito (Java), Kotest + MockK (Kotlin)
- `@SpringBootTest` for integration tests
- `@WebMvcTest` for controller-only tests
