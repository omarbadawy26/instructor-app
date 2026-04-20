FROM maven:3.9.9-eclipse-temurin-17
LABEL authors="shosha"

WORKDIR /app

COPY pom.xml /app
RUN mvn dependency:go-offline

COPY src /app/src

# السطر ده بيبني المشروع
RUN mvn package -DskipTests

# --- التعديل هنا ---
# بننسخ الملف لمكان ثابت واسم ثابت عشان منغلطش في المسار
RUN cp target/*.war /app/app.war || cp target/*.jar /app/app.war

EXPOSE 8080

# بنشغل الملف من مكانه الجديد
CMD ["java", "-jar", "/app/app.war"]