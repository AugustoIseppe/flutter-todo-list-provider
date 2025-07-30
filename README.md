# ✅ Todo List Provider

Um aplicativo Flutter moderno de lista de tarefas, utilizando `Provider` para gerenciamento de estado e persistência local com `SQLite`. O projeto também integra autenticação com Firebase e suporte a login via Google.

---

## 🛠️ Tecnologias Utilizadas

- 💙 **Flutter SDK** (`^3.5.4`)
- 📦 **Provider** - Gerenciamento de estado
- 💾 **SQLite** (`sqflite`, `sqflite_common`, `synchronized`, `path`) - Armazenamento local
- 🔐 **Firebase Auth** e **Google Sign-In**
- ☁️ **Cloud Firestore** - Armazenamento em nuvem
- 🧪 **flutter_test** e **flutter_lints** - Testes e boas práticas
- 🔤 **Google Fonts** - Fontes personalizadas
- 🗓️ **Date Picker Timeline** - Seleção de datas com timeline
- 🧪 **Validatorless** - Validação de formulários
- 🎛️ **flutter_overlay_loader** - Loader customizado para UX
- 🔣 **Fontes customizadas** - `TodoListIcons.ttf`

---

## ✨ Funcionalidades

- 📋 Adição, edição e remoção de tarefas
- 📅 Visualização de tarefas por data
- 🔁 Sincronização com Firebase Firestore
- 👤 Login com Google e Firebase
- 💾 Armazenamento local usando SQLite
- 🎨 Interface com `Google Fonts` e design customizado

---

## 🔧 Como Rodar Localmente

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/todo_list_provider.git
   cd todo_list_provider
   ```

2. Instale as dependências:
   ```bash
   flutter pub get
   ```

3. Execute o app:
   ```bash
   flutter run
   ```

> 📱 Certifique-se de ter um emulador ou dispositivo físico conectado.

---

## 🗂️ Estrutura de Diretórios (Exemplo)

```
lib/
├── models/
├── services/
├── providers/
├── ui/
│   ├── pages/
│   └── components/
└── main.dart
assets/
└── fonts/
    └── TodoListIcons.ttf
```

---

## 🔐 Configuração do Firebase

- Adicione seu arquivo `google-services.json` (Android) e/ou `GoogleService-Info.plist` (iOS) nas pastas apropriadas.
- No [Firebase Console](https://console.firebase.google.com/):
  - Habilite os métodos de login desejados (Google e Email/Senha).
  - Configure Firestore para armazenar os dados da aplicação.

---

## 🧠 Gerenciamento de Estado

Este projeto utiliza o pacote [`provider`](https://pub.dev/packages/provider) para controlar o estado de maneira reativa e organizada.

---

## 📦 Dependências Principais

| Pacote | Versão |
|--------|--------|
| provider | ^6.1.2 |
| sqflite | ^2.4.1 |
| firebase_auth | ^5.4.2 |
| firebase_core | ^3.11.0 |
| cloud_firestore | ^5.6.3 |
| google_sign_in | ^6.2.2 |
| google_fonts | ^6.2.1 |
| date_picker_timeline | ^1.2.6 |
| validatorless | ^1.2.4 |
| flutter_overlay_loader | ^2.0.0 |

---

## ✍️ Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## 🙋‍♂️ Autor

Desenvolvido por **Augusto Iseppe Balan**.  
📍 Pirassununga - SP, Brasil  
💼 Desenvolvedor de Software | Entusiasta de Flutter, Firebase e UI Clean  
🔗 [LinkedIn](https://www.linkedin.com/in/seu-perfil)  
🔗 [GitHub](https://github.com/seu-usuario)