#!/bin/bash

# Script para verificar el progreso de los pasos

echo "🔍 Verificando el estado del proyecto..."
echo ""

# Verificar Jenkinsfile
if [ -f "Jenkinsfile" ]; then
    echo "✅ Jenkinsfile existe"
    if grep -q "publish docker" Jenkinsfile; then
        echo "✅ Stage 'publish docker' ya está agregado"
    else
        echo "⚠️  Stage 'publish docker' NO está agregado todavía"
    fi
else
    echo "❌ Jenkinsfile NO existe - Ejecuta: jhipster ci-cd"
fi

echo ""

# Verificar pom.xml
if [ -f "pom.xml" ]; then
    echo "✅ pom.xml existe"
    if grep -q "DOCKER_REGISTRY_USER" pom.xml; then
        echo "✅ pom.xml ya tiene configuración de DockerHub"
    else
        if grep -q "prueba:latest" pom.xml; then
            echo "⚠️  pom.xml necesita ser modificado (tiene 'prueba:latest')"
        else
            echo "⚠️  pom.xml necesita configuración de DockerHub"
        fi
    fi
else
    echo "❌ pom.xml NO existe"
fi

echo ""
echo "📋 Próximos pasos:"
echo "   1. Si no tienes Jenkinsfile: jhipster ci-cd"
echo "   2. Modificar Jenkinsfile para agregar stage 'publish docker'"
echo "   3. Modificar pom.xml con tu usuario de DockerHub"

