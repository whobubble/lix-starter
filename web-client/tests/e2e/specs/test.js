// https://docs.cypress.io/api/introduction/api.html

describe("Counter Engine", () => {
  it("Visits the app root url", () => {
    cy.visit("/");
    cy.contains("h1", "Welcome to Your Vue.js App");
  });
  it("Should open counter page", () => {
    cy.get('[href="#/counters"]').click();
    cy.contains("h1", "This is a page with counters");
  });
  it("Should create counter asdf", () => {
    cy.get('[href="#/counters"]').click();
    cy.get("input").type("asdf");
    cy.get("button").click();
    cy.contains("Counter asdf");
    cy.get("span > div > input").should("have.value", "3");
    cy.get("span > div > :nth-child(3)").click();
    cy.get("span > div > input").should("have.value", "4");
    cy.get("span > div > :nth-child(1)").click();
    cy.get("span > div > input").should("have.value", "3");
  });
});
