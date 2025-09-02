## Qué es XXE, rápido

XML permite declarar **entidades** en el DTD. Una entidad es como una “variable” que, al **parsear** el XML, el parser sustituye por su contenido. Si la entidad apunta a un recurso externo (archivo, URL, etc.), se llama **External Entity**.

Tu XML:

```xml 
<?xml version="1.0"?>
<!DOCTYPE root [
  <!ENTITY test SYSTEM 'file:///c:/windows/win.ini'>
]>
<order>
  <quantity>123</quantity>
  <item>&test;</item>
  <address>123</address>
</order>

```


- En el DTD defines una entidad **general** llamada `test` que apunta al fichero `C:\Windows\win.ini`.
    
- Cuando el parser procesa `<item>&test;</item>`, **expande** `&test;` y mete el contenido del archivo dentro del elemento `<item>`.
    

## ¿Por qué “tuve que poner `&test;` para que se muestre”?

Declarar la entidad en el DTD **no hace nada por sí mismo**. Es solo la **definición**.  
Para que el parser la use, tienes que **referenciarla** en el contenido del XML con `&nombre;`.

- `<!ENTITY test SYSTEM 'file:///c:/windows/win.ini'>` → **define** la entidad.
    
- `&test;` → **invoca**/**expande** la entidad (sustitución en tiempo de parseo).
    
- Si no la pones en ningún sitio (p.ej. dentro de `<item>`), **nada se “muestra”** porque nunca se expande.
    

Además:

- Debe estar **habilitada** la resolución de DTD/entidades externas en el parser. Muchos parsers modernos la desactivan por seguridad; si está desactivada, `&test;` no se expandirá.
    
- El esquema `file://` hace que el parser lea el archivo local del **servidor que parsea**, no de tu máquina cliente.
    

## ¿Qué “muestra” exactamente?

El **contenido del archivo** se inserta como texto donde coloques `&test;`. En tu caso, aparece **dentro de `<item>`**. Por eso lo ves “ahí”.

## Riesgos típicos de XXE

- **Exfiltración de ficheros**: `file:///etc/passwd`, `file:///c:/Windows/win.ini`, etc.
    
- **SSRF**: `SYSTEM 'http://127.0.0.1:8080/admin'`
    
- **Blind XXE**: enviar el contenido a un endpoint que controlas (out-of-band).
    
- **DoS** con entidades expansivas (“billion laughs”).
    

## Cómo mitigar (muy importante)

Desactiva DTD y entidades externas en el parser. Ejemplos:

**Java (SAX/DOM):**

`factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true); factory.setFeature("http://xml.org/sax/features/external-general-entities", false); factory.setFeature("http://xml.org/sax/features/external-parameter-entities", false); factory.setXIncludeAware(false); factory.setExpandEntityReferences(false);`

**.NET (C#):**

`var settings = new XmlReaderSettings {     DtdProcessing = DtdProcessing.Prohibit,     XmlResolver = null };`

**Python (lxml / stdlib):**

- Usa `defusedxml`:
    

`from defusedxml.ElementTree import fromstring fromstring(xml_data)  # DTD/XXE mitigado`

- O en `lxml`:
    

`parser = lxml.etree.XMLParser(resolve_entities=False, load_dtd=False) root = lxml.etree.fromstring(xml_data, parser=parser)`

**PHP (libxml):**

`libxml_disable_entity_loader(true); // (en versiones antiguas) $dom = new DOMDocument(); $dom->loadXML($xml, LIBXML_NONET | LIBXML_NOENT | LIBXML_DTDLOAD); // evita NOENT/DTDLOAD si no lo necesitas`

**Reglas generales:**

- Rechaza `DOCTYPE` si no es estrictamente necesario.
    
- Deshabilita la resolución de entidades externas.
    
- Valida/normaliza entrada y usa listas blancas de esquemas (sin `file://`, `http://`, etc.).
    
- Limita tamaño y profundidad de entidades.