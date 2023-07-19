from flask import Flask, jsonify, request

app = Flask(__name__)

# Sample data for testing
books = [
    {"id": 1, "title": "Book 1", "author": "Author 1", "published_date": "2021-01-01"},
    {"id": 2, "title": "Book 2", "author": "Author 2", "published_date": "2021-02-01"},
    {"id": 3, "title": "Book 3", "author": "Author 3", "published_date": "2021-03-01"}
]

# List all books
@app.route('/books', methods=['GET'])
def get_books():
    return jsonify(books)

# Get a specific book by ID
@app.route('/books/<int:book_id>', methods=['GET'])
def get_book(book_id):
    book = next((book for book in books if book['id'] == book_id), None)
    if book:
        return jsonify(book)
    return jsonify({'message': 'Book not found'}), 404

# Create a new book
@app.route('/books', methods=['POST'])
def create_book():
    new_book = {
        'id': len(books) + 1,
        'title': request.json['title'],
        'author': request.json['author'],
        'published_date': request.json['published_date']
    }
    books.append(new_book)
    return jsonify(new_book), 201

# Update an existing book
@app.route('/books/<int:book_id>', methods=['PUT'])
def update_book(book_id):
    book = next((book for book in books if book['id'] == book_id), None)
    if book:
        book['title'] = request.json.get('title', book['title'])
        book['author'] = request.json.get('author', book['author'])
        book['published_date'] = request.json.get('published_date', book['published_date'])
        return jsonify(book)
    return jsonify({'message': 'Book not found'}), 404

# Delete a book
@app.route('/books/<int:book_id>', methods=['DELETE'])
def delete_book(book_id):
    book = next((book for book in books if book['id'] == book_id), None)
    if book:
        books.remove(book)
        return jsonify({'message': 'Book deleted'})
    return jsonify({'message': 'Book not found'}), 404

if __name__ == '__main__':
    app.run()
