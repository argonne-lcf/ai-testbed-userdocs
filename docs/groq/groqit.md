# GroqIt

This applies to any PyTorch, Keras, or ONNX model that instantiates the
model and invokes it against some inputs inputs, call groqit(model, inputs).

For example the [HuggingFace example for GPT-2](https://huggingface.co/gpt2)

Provides the script:

```python
from transformers import GPT2Tokenizer, GPT2Model
tokenizer = GPT2Tokenizer.from_pretrained('gpt2')
model = GPT2Model.from_pretrained('gpt2')
text = "Replace me by any text you'd like."
encoded_input = tokenizer(text, return_tensors='pt')
output = model(**encoded_input)
```

At the top of the code:

```python
import groqit
```

At the bottom of the code:

```python
groqit(model, encoded_input)
```

These are the instructions for attempting to build a model for Groq.
It is still up to Groq Compiler and Assembler to handle the model.
The small parameterization of GPT-2 will work, but the full
sized > 1B parameter version probably will not work yet.
