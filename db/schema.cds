namespace tutorial.db;

using {
    cuid,
    managed
} from '@sap/cds/common';

entity Books : cuid, managed {
    title       : String;
    author      : Association to Authors;
    genre       : String;
    publishedAt : Date;
    pages       : Integer;
    price       : Decimal(9, 2);
    stock       : Integer;
    status      : Association to BookStatus;
    Chapters    : Composition of many Chapters
                      on Chapters.book = $self;
}

entity BookStatus {
    key code        : String(1) enum {
            Available = 'A';
            Lowstock = 'L';
            Unavailable = 'U';
        }
        criticality : Integer;
        displaytext : String;
}

type BookStatusCode : String(1) enum {
    Available = 'A';
    Lowstock = 'L';
    Unavailable = 'U';
}

entity Authors : cuid, managed {
    name  : String;
    books : Association to many Books
                on books.author = $self;
}

entity Chapters : cuid, managed {
    key book   : Association to Books;
        number : Integer;
        title  : String;
        pages  : Integer;
}