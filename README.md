# Task Manager

A simple task management application built with Ruby on Rails that allows users to create lists and manage tasks within those lists.

## Features

- Create, read, update, and delete lists
- Add, edit, and remove tasks within lists
- Mark tasks as complete/incomplete
- Filter tasks by status (All/Completed/Incomplete)

## Prerequisites

- Ruby 3.2.2
- Rails 7.0 or later
- PostgreSQL 13 or later
- Node.js 16.0.0 or later
- Yarn

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/task_manager.git
cd task_manager
```

### 2. Install dependencies

```bash
bundle install
yarn install
```

### 3. Set up the database

```bash
# Create and migrate the database
rails db:create
rails db:migrate
```

### 4. Start the server

```bash
rails server
```

The application will be available at `http://localhost:3000`

## Running Tests

To run the full test suite:

```bash
bundle exec rspec
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built with Ruby on Rails
- Styled with Bootstrap 5
- Tested with RSpec
