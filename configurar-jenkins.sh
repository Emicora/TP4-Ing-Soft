#!/bin/bash

echo "🚀 Configuración de Jenkins - Paso 6 y 7"
echo "========================================"
echo ""

# Verificar que Jenkins está corriendo
if docker ps | grep -q jenkins; then
    echo "✅ Jenkins está corriendo"
    echo "   Accede a: http://localhost:8080"
else
    echo "❌ Jenkins NO está corriendo"
    echo "   Iniciando Jenkins..."
    docker start jenkins
    sleep 5
    echo "✅ Jenkins iniciado"
fi

echo ""
echo "📋 INSTRUCCIONES PASO A PASO:"
echo ""
echo "1. Abre tu navegador en: http://localhost:8080"
echo ""
echo "2. Si es la primera vez, necesitas la contraseña inicial:"
if docker exec jenkins test -f /var/jenkins_home/secrets/initialAdminPassword 2>/dev/null; then
    echo "   Contraseña: $(docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword)"
else
    echo "   Jenkins ya está configurado, inicia sesión con tu usuario"
fi
echo ""
echo "3. Configurar herramientas (Maven y JDK):"
echo "   - Ve a: Manage Jenkins → Tools"
echo "   - Agrega Maven (nombre: 'Maven')"
echo "   - Agrega JDK (nombre: 'JDK')"
echo ""
echo "4. Crear credenciales de DockerHub:"
echo "   - Ve a: Manage Jenkins → Credentials → Global → Add Credentials"
echo "   - Kind: Username with password"
echo "   - ID: dockerhub-login"
echo "   - Username: emicora"
echo "   - Password: [tu contraseña de DockerHub]"
echo ""
echo "5. Crear Pipeline Job:"
echo "   - New Item → Nombre: 'PublicarEnDocker' → Pipeline"
echo "   - Definition: Pipeline script from SCM"
echo "   - SCM: Git"
echo "   - Repository URL: [URL de tu repositorio GitHub]"
echo "   - Branch: */master (o */main)"
echo "   - Script Path: Jenkinsfile"
echo ""
echo "6. Ejecutar el pipeline:"
echo "   - Ve al job 'PublicarEnDocker'"
echo "   - Clic en 'Build Now'"
echo ""
echo "📖 Para más detalles, revisa: GUIA_PASO_6_7.md"
echo ""

