/*
 * generated by Xtext 2.21.0
 */
package org.example.domainmodel.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import org.example.domainmodel.domainmodel.Entity
import org.eclipse.xtext.naming.IQualifiedNameProvider
import javax.inject.Inject

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class DomainmodelGenerator extends AbstractGenerator {

	@Inject extension IQualifiedNameProvider
	
	
	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {

		// We need to iterate a resource with all its deeply nested elements.
		// Then, how we determine the file name of the Java class that each Entity should yield?
		// The qualified name itself has to be obtained from a special service that is available for each language
		// ^-> We simply injected the IQualifiedNameProvider into the generator
		for (e : resource.allContents.toIterable.filter(Entity)) {
			fsa.generateFile(
            	e.fullyQualifiedName.toString("/") + ".java",
            	e.compile)
        }
	}
	
	// write the actual template code for an entity
	def compile(Entity e) '''
        package «e.eContainer.fullyQualifiedName»;
            
        public class «e.name» {
        }
    '''
}
