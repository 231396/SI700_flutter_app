import Person from './person.js';
import express, { json } from 'express';
import cors from "cors";
const app = express();

app.use(json());
app.use(cors());
app.listen(3000);

app.get('/', (req, res) => {
	res.send('Test');
	console.log("Test");
});

const persons = [ new Person(), new Person() ]

var p1 = persons[0];
p1.name = "Andre";
p1.email = "@@";
p1.password = "123";
p1.gender = "M";

var p2 = persons[1];
p2.name = "Jau";
p2.email = "email@.com";
p2.password = "abc";
p2.gender = "F";

const endpoint = "/person";

//ADD
app.post(endpoint, (req, res) => {
	const person = new Person();
	person.fromJson(req.body);
    persons.push(note);
    res.send("Inserido");
});

//UPDATE
app.put(`${endpoint}/:id`, (req, res) => {
    const id = parseInt(req.params.id);
	const person = new Person();
	person.fromJson(req.body);
	if(id >= 0 && id < persons.length){
		persons[id] = person;
		res.send("Atualizado");
	} else{
		res.send("Falha");
	}
});

//DELETE
app.delete(`${endpoint}/:id`, (req, res) => {
    const id = parseInt(req.params.id);

	if(id >= 0 && id < persons.length){
		delete persons[id];
		res.send("Deletado");
	} else{
		res.send("Falha");
	}
});

app.get(endpoint, (req, res) => {
	var list = [];
	for (let index = 0; index < persons.length; index++) {
		list.push(persons[index].toJson(index));
	}
    res.send(list);
});

app.get(`${endpoint}/:id`, (req, res) => {
    const id = parseInt(req.params.id);
    const person = persons[id];

    if (person)
		res.send(person.toJson());
    else
		res.send("{}");
});

app.get(`${endpoint}/:email/:password`, (req, res) => {
    const email = req.params.email;
    const password = req.params.password;

	const person = persons.find((x) => x.email === email && x.password === password);

    if (person)
		res.send(person.toJson());
    else
        res.send("{}");
});